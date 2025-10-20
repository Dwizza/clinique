package com.cliniquedigitale.repository;

import com.cliniquedigitale.entities.Appointment;
import com.cliniquedigitale.entities.Doctor;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

public interface AppointmentRepository {
    List<Appointment> findByDoctorAndDate(Doctor doctor, LocalDate date);
    Appointment save(Appointment appointment);
    Appointment findByDoctorDateHour(Doctor doctor, LocalDate date, LocalTime hour);
    Appointment findById(UUID id);
}
