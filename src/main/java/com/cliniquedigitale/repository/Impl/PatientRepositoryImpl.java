package com.cliniquedigitale.repository.Impl;

import com.cliniquedigitale.config.JpaUtil;
import com.cliniquedigitale.entities.Patient;
import com.cliniquedigitale.repository.PatientRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

@ApplicationScoped
public class PatientRepositoryImpl implements PatientRepository {

    @Override
    public Patient save(Patient patient) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(patient);
            em.getTransaction().commit();
            return patient;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public Patient findByCin(String cin) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Patient> query = em.createQuery(
                    "SELECT p FROM Patient p WHERE p.cin = :cin", Patient.class
            );
            query.setParameter("cin", cin);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }
}

