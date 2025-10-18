package com.cliniquedigitale.service;

import com.cliniquedigitale.entities.Appointment;
import com.cliniquedigitale.entities.Doctor;
import com.cliniquedigitale.repository.AppointmentRepository;
import com.cliniquedigitale.repository.DoctorRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import java.time.LocalDate;
import java.util.List;

@ApplicationScoped
public class AppointmentService {

    @Inject
    private AppointmentRepository appointmentRepository;

    @Inject
    private DoctorRepository doctorRepository;

    public List<Appointment> getTodayAppointmentsByEmail(String userEmail) {
        if (userEmail == null || userEmail.isBlank()) return List.of();
        Doctor doctor = doctorRepository.findByUserEmail(userEmail);
        if (doctor == null) return List.of();
        return appointmentRepository.findByDoctorAndDate(doctor, LocalDate.now());
    }
}

