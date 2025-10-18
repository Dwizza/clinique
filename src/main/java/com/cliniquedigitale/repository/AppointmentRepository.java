package com.cliniquedigitale.repository;

import com.cliniquedigitale.entities.Appointment;
import com.cliniquedigitale.entities.Doctor;

import java.time.LocalDate;
import java.util.List;

public interface AppointmentRepository {
    List<Appointment> findByDoctorAndDate(Doctor doctor, LocalDate date);
}

