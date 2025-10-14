package com.cliniquedigitale.service;

import com.cliniquedigitale.DTO.DoctorDTO;
import com.cliniquedigitale.DTO.Request.RequestPatientDTO;
import com.cliniquedigitale.DTO.Request.RequestUserDTO;
import com.cliniquedigitale.DTO.Response.ResponseUserDTO;
import com.cliniquedigitale.entities.Doctor;
import com.cliniquedigitale.entities.Specialty;
import com.cliniquedigitale.entities.User;
import com.cliniquedigitale.mapper.DoctorMapper;
import com.cliniquedigitale.mapper.UserMapper;
import com.cliniquedigitale.repository.DoctorRepository;
import com.cliniquedigitale.repository.SpecialtyRepository;
import com.cliniquedigitale.repository.UserRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class DoctorSevice {

    @Inject
    private UserRepository userRepository;

    @Inject
    private DoctorRepository doctorRepository;
    @Inject
    private UserMapper userMapper;
    @Inject
    private DoctorMapper doctorMapper;
    @Inject
    private SpecialtyRepository specialtyRepository;

    public ResponseUserDTO registerDoctor(RequestUserDTO requestUserDto, DoctorDTO doctorDTO) {

        User existingUser = userRepository.FindByEmail(requestUserDto.getEmail());
        if (existingUser != null) {
            throw new IllegalArgumentException("Email déjà utilisé !");
        }

        Doctor existingDoctor = doctorRepository.findByMatricule(doctorDTO.getMatricule());
        if (existingDoctor != null) {
            throw new IllegalArgumentException("Matricule déjà utilisé !");
        }
        Specialty specialty = specialtyRepository.findById(doctorDTO.getSpecialtyId());

        User user = userMapper.toEntity(requestUserDto);
        User persistedUser = userRepository.save(user);
        Doctor doctor = doctorMapper.toEntity(doctorDTO, specialty, user);
        doctorRepository.save(doctor);

        return UserMapper.toResponse(persistedUser);
    }
}
