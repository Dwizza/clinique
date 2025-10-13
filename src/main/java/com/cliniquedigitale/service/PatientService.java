package com.cliniquedigitale.service;

import com.cliniquedigitale.entities.Patient;
import com.cliniquedigitale.repository.Impl.PatientRepositoryImpl;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import java.util.List;

@ApplicationScoped
public class PatientService {

    @Inject
    private PatientRepositoryImpl patientRepository;

    public List<Patient> getAll(){
        return patientRepository.findAll();
    }
}
