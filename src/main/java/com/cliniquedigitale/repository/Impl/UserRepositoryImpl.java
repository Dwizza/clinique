package com.cliniquedigitale.repository.Impl;

import com.cliniquedigitale.config.JpaUtil;
import com.cliniquedigitale.entities.User;
import com.cliniquedigitale.repository.UserRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;

@ApplicationScoped
public class UserRepositoryImpl implements UserRepository {

    public void save(User user){

    }

    public User FindByEmail(String email){
        String qr = "SELECT u FROM User u WHERE u.email = :email";
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery(qr, User.class)
                    .setParameter("email", email)
                    .getResultStream()
                    .findFirst()
                    .orElse(null);
        } finally {
            em.close();
        }
    }
}
