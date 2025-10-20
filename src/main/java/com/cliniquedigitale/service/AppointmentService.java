package com.cliniquedigitale.service;

import com.cliniquedigitale.Enums.Jour;
import com.cliniquedigitale.Enums.StatutAppointment;
import com.cliniquedigitale.Enums.StatutDispo;
import com.cliniquedigitale.Enums.TypeAppointment;
import com.cliniquedigitale.entities.Appointment;
import com.cliniquedigitale.entities.Availability;
import com.cliniquedigitale.entities.Doctor;
import com.cliniquedigitale.entities.Patient;
import com.cliniquedigitale.repository.AppointmentRepository;
import com.cliniquedigitale.repository.AvailabilityRepository;
import com.cliniquedigitale.repository.DoctorRepository;
import com.cliniquedigitale.repository.PatientRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import java.time.*;
import java.util.*;

@ApplicationScoped
public class AppointmentService {

    @Inject
    private AppointmentRepository appointmentRepository;

    @Inject
    private DoctorRepository doctorRepository;

    @Inject
    private AvailabilityRepository availabilityRepository;

    @Inject
    private PatientRepository patientRepository;

    public List<Appointment> getTodayAppointmentsByEmail(String userEmail) {
        if (userEmail == null || userEmail.isBlank()) return List.of();
        Doctor doctor = doctorRepository.findByUserEmail(userEmail);
        if (doctor == null) return List.of();
        return appointmentRepository.findByDoctorAndDate(doctor, LocalDate.now());
    }

    public List<LocalTime> getAvailableSlots(UUID doctorId, LocalDate date) {
        if (doctorId == null || date == null) return List.of();
        Doctor doctor = doctorRepository.findById(doctorId);
        if (doctor == null) return List.of();

        Jour jour = mapToJour(date.getDayOfWeek());
        List<Availability> availabilities = availabilityRepository.findByDoctorAndJour(doctor, jour);

        final int SLOT_MINUTES = 30;
        Set<LocalTime> slots = new TreeSet<>();
        for (Availability a : availabilities) {
            if (a == null || a.getStatut() != StatutDispo.AVAILABLE) continue;
            if (a.getHeureDebut() == null || a.getHeureFin() == null) continue;
            LocalTime start = a.getHeureDebut();
            LocalTime end = a.getHeureFin();
            if (!end.isAfter(start)) continue;
            LocalTime t = start;
            // hna kanzid 30 min ou kanchouf wach ft end
            while (!t.plusMinutes(SLOT_MINUTES).isAfter(end)) {
                // pause (12:00 - 13:00)
                if (!(t.isBefore(LocalTime.NOON.plusHours(1)) && !t.isBefore(LocalTime.NOON))) {
                    // Ajouter t dans treeSet
                    slots.add(t);
                }
                //kan7at le nouveau temps t + 30min(SLOT_MINUTES)
                t = t.plusMinutes(SLOT_MINUTES);
            }
        }
        // list dyal appointment lkoula doctor ou kan7ydhoum mn slots (treeSet)
        List<Appointment> dayAppointments = appointmentRepository.findByDoctorAndDate(doctor, date);
        for (Appointment ap : dayAppointments) {
            if (ap.getHour() != null) slots.remove(ap.getHour());
        }

        if (date.isEqual(LocalDate.now())) {
            LocalTime minTime = LocalTime.now().plusHours(2).withSecond(0).withNano(0);
            slots.removeIf(t -> !t.isAfter(minTime));
        }

        return new ArrayList<>(slots);
    }

    public Appointment bookAppointment(UUID doctorId, String patientEmail, LocalDate date, LocalTime time, TypeAppointment type) {
        if (doctorId == null || date == null || time == null || type == null || patientEmail == null || patientEmail.isBlank()) {
            throw new IllegalArgumentException("Paramètres manquants");
        }
        Doctor doctor = doctorRepository.findById(doctorId);
        if (doctor == null) throw new IllegalArgumentException("Docteur introuvable");
        Patient patient = patientRepository.findByUserEmail(patientEmail);
        if (patient == null) throw new IllegalArgumentException("Patient introuvable");

        List<LocalTime> available = getAvailableSlots(doctorId, date);
        if (available.stream().noneMatch(t -> t.equals(time))) {
            throw new IllegalArgumentException("Créneau non disponible");
        }

        if (appointmentRepository.findByDoctorDateHour(doctor, date, time) != null) {
            throw new IllegalArgumentException("Créneau déjà réservé");
        }

        Appointment ap = new Appointment();
        ap.setDoctor(doctor);
        ap.setPatient(patient);
        ap.setDate(date);
        ap.setHour(time);
        ap.setType(type);
        ap.setStatut(StatutAppointment.PLANNED);
        return appointmentRepository.save(ap);
    }

    public void cancelAppointment(UUID appointmentId, String patientEmail) {
        if (appointmentId == null || patientEmail == null || patientEmail.isBlank()) {
            throw new IllegalArgumentException("Paramètres manquants");
        }
        Appointment ap = appointmentRepository.findById(appointmentId);
        if (ap == null) throw new IllegalArgumentException("Rendez-vous introuvable");
        if (ap.getPatient() == null || ap.getPatient().getUser() == null || ap.getPatient().getUser().getEmail() == null
                || !patientEmail.equalsIgnoreCase(ap.getPatient().getUser().getEmail())) {
            throw new SecurityException("Interdit");
        }

        LocalDateTime apDateTime = LocalDateTime.of(ap.getDate(), ap.getHour());
        if (Duration.between(LocalDateTime.now(), apDateTime).toHours() < 12) {
            throw new IllegalArgumentException("Délai d'annulation expiré");
        }
        ap.setStatut(StatutAppointment.CANCELED);
        appointmentRepository.save(ap);
    }

    private Jour mapToJour(DayOfWeek dow) {
        return switch (dow) {
            case MONDAY -> Jour.LUNDI;
            case TUESDAY -> Jour.MARDI;
            case WEDNESDAY -> Jour.MERCREDI;
            case THURSDAY -> Jour.JEUDI;
            case FRIDAY -> Jour.VENDREDI;
            case SATURDAY -> Jour.SAMEDI;
            case SUNDAY -> Jour.DIMANCHE;
        };
    }
}
