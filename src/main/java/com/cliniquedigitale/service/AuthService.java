package com.cliniquedigitale.service;

import com.cliniquedigitale.DTO.Request.RequestPatientDTO;
import com.cliniquedigitale.DTO.Request.RequestUserDTO;
import com.cliniquedigitale.DTO.Response.ResponseUserDTO;
import com.cliniquedigitale.Enums.Role;
import com.cliniquedigitale.entities.Patient;
import com.cliniquedigitale.entities.User;
import com.cliniquedigitale.mapper.PatientMapper;
import com.cliniquedigitale.mapper.UserMapper;
import com.cliniquedigitale.repository.PatientRepository;
import com.cliniquedigitale.repository.UserRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class AuthService {

    @Inject
    private UserRepository userRepository;

    @Inject
    private UserMapper userMapper;

    @Inject
    private PatientMapper patientMapper;

    @Inject
    private PatientRepository patientRepository;

    public ResponseUserDTO Login(RequestUserDTO request){
        User user = userRepository.FindByEmail(request.getEmail());
        ResponseUserDTO dto = UserMapper.toResponse(user);

        if (user != null && user.getPassword().equals(request.getPassword())) {
            return dto;
        }
        return null;
    }

    public ResponseUserDTO registerPatient(RequestUserDTO requestUserDto, RequestPatientDTO requestPatientDto) {

        User existingUser = userRepository.FindByEmail(requestUserDto.getEmail());
        if (existingUser != null) {
            throw new IllegalArgumentException("Email déjà utilisé !");
        }

        Patient existingPatient = patientRepository.findByCin(requestPatientDto.getCin());
        if (existingPatient != null) {
            throw new IllegalArgumentException("CIN déjà utilisé !");
        }

        User user = userMapper.toEntity(requestUserDto);

        User persistedUser = userRepository.save(user);

        Patient patient = new Patient();
        patient.setCin(requestPatientDto.getCin());
        patient.setNaissance(requestPatientDto.getNaissance());
        patient.setSexe(requestPatientDto.getSexe());
        patient.setAdresse(requestPatientDto.getAdresse());
        patient.setTelephone(requestPatientDto.getTelephone());
        patient.setSang(requestPatientDto.getSang());
        patient.setUser(persistedUser);

        patientRepository.save(patient);

        return UserMapper.toResponse(persistedUser);
    }

}
