package com.cliniquedigitale.service;

import com.cliniquedigitale.Enums.Role;
import com.cliniquedigitale.entities.User;
import com.cliniquedigitale.repository.UserRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class UserService {

    @Inject
    private UserRepository userRepository;

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public List<User> getUsersByRole(Role role) {
        return userRepository.findByRole(role);
    }

    public User getUserById(UUID id) {
        return userRepository.findById(id);
    }

    public void toggleUserStatus(UUID userId) {
        userRepository.toggleUserStatus(userId);
    }

    public long countByRole(Role role) {
        return getUsersByRole(role).size();
    }

    public long countActiveUsers() {
        return getAllUsers().stream().filter(User::isActif).count();
    }
}

