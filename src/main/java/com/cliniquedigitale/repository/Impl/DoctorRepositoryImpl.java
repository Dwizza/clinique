package com.cliniquedigitale.repository.Impl;

import com.cliniquedigitale.config.JpaUtil;
import com.cliniquedigitale.entities.Doctor;
import com.cliniquedigitale.repository.DoctorRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import java.util.UUID;


@ApplicationScoped
public class DoctorRepositoryImpl implements DoctorRepository {

    @Override
    public Doctor save(Doctor doctor) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(doctor);
            em.getTransaction().commit();
            return doctor;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public Doctor findByMatricule(String matricule) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Doctor> q = em.createQuery("SELECT d FROM Doctor d WHERE d.matricule = :matricule", Doctor.class);
            q.setParameter("matricule", matricule);
            return q.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public Doctor findByUserEmail(String email) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Doctor> q = em.createQuery("SELECT d FROM Doctor d WHERE d.user.email = :email", Doctor.class);
            q.setParameter("email", email);
            return q.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public Doctor findById(UUID id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Doctor.class, id);
        } finally {
            em.close();
        }
    }
}
