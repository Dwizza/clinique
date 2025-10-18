package com.cliniquedigitale.repository;

import com.cliniquedigitale.entities.Availability;
import com.cliniquedigitale.entities.Doctor;
import com.cliniquedigitale.Enums.Jour;

import java.util.List;
import java.util.UUID;

public interface AvailabilityRepository {
    Availability save(Availability availability);
    void saveAll(List<Availability> availabilities);
    List<Availability> findByDoctorAndJour(Doctor doctor, Jour jour);
    void deleteByDoctorAndJour(Doctor doctor, Jour jour);
    List<Availability> findByDoctor(UUID doctorId);
}

