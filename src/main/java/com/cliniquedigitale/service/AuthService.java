package com.cliniquedigitale.service;

import com.cliniquedigitale.entities.User;
import com.cliniquedigitale.repository.UserRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class AuthService {

    @Inject
    private UserRepository userRepository;

    public User Login(String email, String password){
        User user = userRepository.FindByEmail(email);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }
}
