package com.cliniquedigitale.service;

import com.cliniquedigitale.DTO.Request.RequestUserDTO;
import com.cliniquedigitale.DTO.Response.ResponseUserDTO;
import com.cliniquedigitale.entities.User;
import com.cliniquedigitale.mapper.UserMapper;
import com.cliniquedigitale.repository.StaffRepository;
import com.cliniquedigitale.repository.UserRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;


@ApplicationScoped
public class StaffService {

    @Inject
    private StaffRepository staffRepository;

    @Inject
    private UserMapper userMapper;

    @Inject
    private UserRepository userRepository;

    public ResponseUserDTO registerStaff(RequestUserDTO requestUserDto){
        User existingUser = userRepository.FindByEmail(requestUserDto.getEmail());
        if (existingUser != null) {
            throw new IllegalArgumentException("Email déjà utilisé !");
        }
        User user = userMapper.toEntity(requestUserDto);
        User persistedUser = userRepository.save(user);

        return UserMapper.toResponse(persistedUser);
    }
}
