package com.cliniquedigitale.repository.Impl;

import com.cliniquedigitale.config.JpaUtil;
import com.cliniquedigitale.entities.Doctor;
import com.cliniquedigitale.repository.DoctorRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import java.util.List;
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

    @Override
    public List<Doctor> searchDoctors(String searchTerm) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT d FROM Doctor d " +
                         "JOIN d.user u " +
                         "JOIN d.specialite s " +
                         "WHERE LOWER(u.name) LIKE LOWER(:searchTerm) " +
                         "OR LOWER(s.name) LIKE LOWER(:searchTerm) " +
                         "OR LOWER(d.matricule) LIKE LOWER(:searchTerm)";
            TypedQuery<Doctor> query = em.createQuery(jpql, Doctor.class);
            query.setParameter("searchTerm", "%" + searchTerm + "%");
            List<Doctor> doctors = query.getResultList();

            // Charger les associations en lazy loading
            for (Doctor doctor : doctors) {
                doctor.getUser().getName(); // Force le chargement de user
                doctor.getSpecialite().getName(); // Force le chargement de specialite
            }

            return doctors;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Doctor> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Doctor> query = em.createQuery(
                "SELECT d FROM Doctor d",
                Doctor.class
            );
            List<Doctor> doctors = query.getResultList();

            // Charger les associations en lazy loading
            for (Doctor doctor : doctors) {
                doctor.getUser().getName();
                doctor.getSpecialite().getName();
            }

            return doctors;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Doctor> findBySpeciality(UUID specialityId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Doctor> query = em.createQuery(
                "SELECT d FROM Doctor d " +
                "JOIN d.specialite s " +
                "WHERE s.id = :specialityId",
                Doctor.class
            );
            query.setParameter("specialityId", specialityId);
            List<Doctor> doctors = query.getResultList();

            // Charger les associations en lazy loading
            for (Doctor doctor : doctors) {
                doctor.getUser().getName();
                doctor.getSpecialite().getName();
            }

            return doctors;
        } finally {
            em.close();
        }
    }
}
