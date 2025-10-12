package com.cliniquedigitale.repository;

import com.cliniquedigitale.entities.Patient;

public interface PatientRepository {
    Patient save(Patient patient);
    Patient findByCin(String cin);
}

