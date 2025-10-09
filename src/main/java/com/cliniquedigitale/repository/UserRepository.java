package com.cliniquedigitale.repository;

import com.cliniquedigitale.entities.User;

public interface UserRepository {

    void save(User user);
    User FindByEmail(String email);
}
