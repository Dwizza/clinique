package com.cliniquedigitale.repository;

import com.cliniquedigitale.entities.User;
import com.cliniquedigitale.Enums.Role;
import java.util.List;
import java.util.UUID;

public interface UserRepository {

    User save(User user);
    User FindByEmail(String email);
    User findById(UUID id);
    List<User> findAll();
    List<User> findByRole(Role role);
    User update(User user);
    void toggleUserStatus(UUID userId);
}
