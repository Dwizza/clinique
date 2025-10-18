package com.cliniquedigitale.service;

import com.cliniquedigitale.DTO.AvailabilityDTO;
import com.cliniquedigitale.Enums.Jour;
import com.cliniquedigitale.Enums.StatutDispo;
import com.cliniquedigitale.entities.Availability;
import com.cliniquedigitale.entities.Doctor;
import com.cliniquedigitale.mapper.AvailabilityMapper;
import com.cliniquedigitale.repository.AvailabilityRepository;
import com.cliniquedigitale.repository.DoctorRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.*;

@ApplicationScoped
public class AvailabilityService {

    @Inject
    private AvailabilityRepository availabilityRepository;

    @Inject
    private DoctorRepository doctorRepository;

    @Inject
    private AvailabilityMapper availabilityMapper;

    @SuppressWarnings("unused")
    public List<Availability> getAvailability(String doctorId){
        List<Availability> availabilityList = new ArrayList<>();
        List<Availability> availabilities = availabilityRepository.findByDoctor(UUID.fromString(doctorId));
        for (Availability a : availabilities){
            if (a.getStatut() == StatutDispo.AVAILABLE){
                availabilityList.add(a);
            }
        }
        return availabilityList;
    }

    public List<AvailabilityDTO> getAvailabilityByEmail(String userEmail) {
        if (userEmail == null || userEmail.isBlank()) return Collections.emptyList();
        Doctor doctor = doctorRepository.findByUserEmail(userEmail);
        if (doctor == null) return Collections.emptyList();
        List<Availability> all = availabilityRepository.findByDoctor(doctor.getId());
        List<Availability> availables = new ArrayList<>();
        for (Availability a : all) if (a.getStatut() == StatutDispo.AVAILABLE) availables.add(a);
        return availabilityMapper.toDTOList(availables);
    }

    public List<AvailabilityDTO> getTodayAvailabilityByEmail(String userEmail) {
        if (userEmail == null || userEmail.isBlank()) return Collections.emptyList();
        Doctor doctor = doctorRepository.findByUserEmail(userEmail);
        if (doctor == null) return Collections.emptyList();
        Jour todayJour = mapToJour(LocalDate.now().getDayOfWeek());
        List<Availability> list = availabilityRepository.findByDoctorAndJour(doctor, todayJour);
        List<Availability> availables = new ArrayList<>();
        for (Availability a : list) if (a.getStatut() == StatutDispo.AVAILABLE) availables.add(a);
        availables.sort(Comparator.comparing(Availability::getHeureDebut, Comparator.nullsLast(Comparator.naturalOrder())));
        return availabilityMapper.toDTOList(availables);
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

    @SuppressWarnings("unused")
    public void saveWeekly(String userEmail, List<Jour> jours, List<LocalTime[]> slots) {
        if (userEmail == null || userEmail.isBlank()) throw new IllegalArgumentException("email requis");
        if (jours == null || jours.isEmpty()) return;
        if (slots == null || slots.isEmpty()) return;

        Doctor doctor = doctorRepository.findByUserEmail(userEmail);
        if (doctor == null) throw new IllegalStateException("Médecin introuvable pour l'utilisateur: " + userEmail);

        for (Jour jour : jours) {
            availabilityRepository.deleteByDoctorAndJour(doctor, jour);
            List<Availability> toSave = new ArrayList<>();
            for (LocalTime[] tr : slots) {
                LocalTime start = tr[0];
                LocalTime end = tr[1];
                if (start == null || end == null || !end.isAfter(start)) continue;
                Availability a = new Availability();
                a.setDoctor(doctor);
                a.setJour(jour);
                a.setHeureDebut(start);
                a.setHeureFin(end);
                a.setStatut(StatutDispo.ON_LEAVE);
                a.setValide(true);
                toSave.add(a);
            }
            availabilityRepository.saveAll(toSave);
        }
    }

    public void saveDaily(String userEmail, Map<Jour, List<LocalTime[]>> daySlots) {
        if (userEmail == null || userEmail.isBlank()) throw new IllegalArgumentException("email requis");
        if (daySlots == null || daySlots.isEmpty()) return;

        Doctor doctor = doctorRepository.findByUserEmail(userEmail);
        if (doctor == null) throw new IllegalStateException("Médecin introuvable pour l'utilisateur: " + userEmail);

        for (Map.Entry<Jour, List<LocalTime[]>> entry : daySlots.entrySet()) {
            Jour jour = entry.getKey();
            List<LocalTime[]> slots = entry.getValue();
            availabilityRepository.deleteByDoctorAndJour(doctor, jour);
            List<Availability> toSave = new ArrayList<>();
            for (LocalTime[] tr : slots) {
                LocalTime start = tr[0];
                LocalTime end = tr[1];
                if (start == null || end == null || !end.isAfter(start)) continue;
                Availability a = new Availability();
                a.setDoctor(doctor);
                a.setJour(jour);
                a.setHeureDebut(start);
                a.setHeureFin(end);
                a.setStatut(StatutDispo.AVAILABLE);
                a.setValide(true);
                toSave.add(a);
            }
            availabilityRepository.saveAll(toSave);
        }
    }

    public void saveDaily(String userEmail, List<AvailabilityDTO> availabilityDTOs) {
        if (userEmail == null || userEmail.isBlank()) throw new IllegalArgumentException("email requis");
        if (availabilityDTOs == null || availabilityDTOs.isEmpty()) return;
        Doctor doctor = doctorRepository.findByUserEmail(userEmail);
        if (doctor == null) throw new IllegalStateException("Médecin introuvable pour l'utilisateur: " + userEmail);

        Map<Jour, List<AvailabilityDTO>> grouped = new EnumMap<>(Jour.class);
        for (AvailabilityDTO dto : availabilityDTOs) {
            if (dto == null || dto.getJour() == null) continue;
            if (dto.getHeureDebut() == null || dto.getHeureFin() == null) continue;
            if (!dto.getHeureFin().isAfter(dto.getHeureDebut())) continue;
            grouped.computeIfAbsent(dto.getJour(), k -> new ArrayList<>()).add(dto);
        }
        for (Map.Entry<Jour, List<AvailabilityDTO>> e : grouped.entrySet()) {
            Jour jour = e.getKey();
            List<AvailabilityDTO> list = e.getValue();
            availabilityRepository.deleteByDoctorAndJour(doctor, jour);
            List<Availability> toSave = new ArrayList<>();
            for (AvailabilityDTO dto : list) {
                Availability a = availabilityMapper.toEntity(dto);
                a.setDoctor(doctor);
                if (a.getStatut() == null) a.setStatut(StatutDispo.AVAILABLE);
                a.setValide(true);
                toSave.add(a);
            }
            availabilityRepository.saveAll(toSave);
        }
    }

    public void setOnLeaveDays(String userEmail, Collection<Jour> jours) {
        if (userEmail == null || userEmail.isBlank()) throw new IllegalArgumentException("email requis");
        if (jours == null || jours.isEmpty()) return;
        Doctor doctor = doctorRepository.findByUserEmail(userEmail);
        if (doctor == null) throw new IllegalStateException("Médecin introuvable pour l'utilisateur: " + userEmail);

        for (Jour jour : jours) {
            availabilityRepository.deleteByDoctorAndJour(doctor, jour);
            Availability a = new Availability();
            a.setDoctor(doctor);
            a.setJour(jour);
            a.setHeureDebut(null);
            a.setHeureFin(null);
            a.setStatut(StatutDispo.ON_LEAVE);
            a.setValide(true);
            availabilityRepository.save(a);
        }
    }
}
