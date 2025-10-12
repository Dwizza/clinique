package com.cliniquedigitale.mapper;

import com.cliniquedigitale.DTO.UserDTO;
import com.cliniquedigitale.entities.User;

public class UserMapper {

    public static UserDTO toDTO(User user) {
        if (user == null) {
            return null;
        }
        return new UserDTO(user.getId(), user.getName(), user.getEmail(), user.getPassword(), user.getRole());
    }

    public static User toEntity(UserDTO dto) {
        if (dto == null) {
            return null;
        }

        User user = new User();
        user.setId(dto.getId());
        user.setEmail(dto.getEmail());
        user.setName(dto.getName());
        user.setActif(dto.isActif());
        user.setRole(dto.getRole());

        return user;
    }
}
