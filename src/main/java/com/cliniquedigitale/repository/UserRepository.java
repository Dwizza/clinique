package com.cliniquedigitale.repository;

import com.cliniquedigitale.entities.User;

public interface UserRepository {

    User save(User user);
    User FindByEmail(String email);
}
