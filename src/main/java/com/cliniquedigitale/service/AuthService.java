package com.cliniquedigitale.service;

import com.cliniquedigitale.DTO.UserDTO;
import com.cliniquedigitale.Enums.Role;
import com.cliniquedigitale.entities.Patient;
import com.cliniquedigitale.entities.User;
import com.cliniquedigitale.mapper.UserMapper;
import com.cliniquedigitale.repository.PatientRepository;
import com.cliniquedigitale.repository.UserRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import java.time.LocalDate;
import java.util.UUID;

@ApplicationScoped
public class AuthService {

    @Inject
    private UserRepository userRepository;

    @Inject
    private PatientRepository patientRepository;

    public UserDTO Login(String email, String password){
        User user = userRepository.FindByEmail(email);
        UserDTO dto = UserMapper.toDTO(user);

        if (user != null && user.getPassword().equals(password)) {
            return dto;
        }
        return null;
    }

    public UserDTO registerPatient(String name, String email, String password,
                                   String cin, LocalDate naissance, String sexe,
                                   String adresse, String telephone, String sang) {

        User existingUser = userRepository.FindByEmail(email);
        if (existingUser != null) {
            return null;
        }

        Patient existingPatient = patientRepository.findByCin(cin);
        if (existingPatient != null) {
            return null;
        }

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(Role.PATIENT);
        user.setActif(true);

        User persistedUser = userRepository.save(user);

        Patient patient = new Patient();
        patient.setCin(cin);
        patient.setNaissance(naissance);
        patient.setSexe(sexe);
        patient.setAdresse(adresse);
        patient.setTelephone(telephone);
        patient.setSang(sang);
        patient.setUser(persistedUser);

        patientRepository.save(patient);

        return UserMapper.toDTO(persistedUser);
    }
}
