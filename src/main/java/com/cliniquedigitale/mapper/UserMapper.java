package com.cliniquedigitale.mapper;

import com.cliniquedigitale.DTO.Request.RequestUserDTO;
import com.cliniquedigitale.DTO.Response.ResponseUserDTO;
import com.cliniquedigitale.entities.User;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class UserMapper {

    public static User toEntity(RequestUserDTO dto) {
        if (dto == null) {
            return null;
        }
        User user = new User();
        user.setName(dto.getName());
        user.setEmail(dto.getEmail());
        user.setPassword(dto.getPassword());
        user.setActif(dto.isActif());
        user.setRole(dto.getRole());

        return user;
    }

    public static ResponseUserDTO toResponse(User userEntity){
        ResponseUserDTO response = new ResponseUserDTO();
        response.setName(userEntity.getName());
        response.setEmail(userEntity.getEmail());
        response.setRole(userEntity.getRole());
        response.setActif(userEntity.isActif());
        return response;
    }
}
