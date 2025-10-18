package com.cliniquedigitale.repository.Impl;

import com.cliniquedigitale.config.JpaUtil;
import com.cliniquedigitale.Enums.Jour;
import com.cliniquedigitale.entities.Availability;
import com.cliniquedigitale.entities.Doctor;
import com.cliniquedigitale.repository.AvailabilityRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;

import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class AvailabilityRepositoryImpl implements AvailabilityRepository {

    @Override
    public Availability save(Availability availability) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();

            if (availability.getDoctor() != null && availability.getDoctor().getUser().getId() != null) {
                Doctor managed = em.find(Doctor.class, availability.getDoctor().getId());
                if (managed == null) {
                    throw new IllegalStateException("Doctor not found in database for id: " + availability.getDoctor().getId());
                }
                availability.setDoctor(managed);
            } else {
                throw new IllegalArgumentException("Doctor or doctor ID cannot be null");
            }

            em.persist(availability);
            em.getTransaction().commit();
            return availability;

        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void saveAll(List<Availability> availabilities) {
        if (availabilities == null || availabilities.isEmpty()) return;
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            for (Availability a : availabilities) {
                if (a.getDoctor() != null && a.getDoctor().getId() != null) {
                    Doctor managed = em.getReference(Doctor.class, a.getDoctor().getId());
//                    System.out.println("acccccc: " + managed);
                    a.setDoctor(managed);
                }
                em.persist(a);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Availability> findByDoctorAndJour(Doctor doctor, Jour jour) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Availability> q = em.createQuery(
                    "SELECT a FROM Availability a WHERE a.doctor.id = :doctorId AND a.jour = :jour",
                    Availability.class
            );
            q.setParameter("doctorId", doctor.getId());
            q.setParameter("jour", jour);
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public void deleteByDoctorAndJour(Doctor doctor, Jour jour) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Query q = em.createQuery("DELETE FROM Availability a WHERE a.doctor.id = :doctorId AND a.jour = :jour");
            q.setParameter("doctorId", doctor.getId());
            q.setParameter("jour", jour);
            q.executeUpdate();
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Availability> findByDoctor(UUID doctorId){
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Availability> q = em.createQuery(
                    "SELECT a FROM Availability a WHERE a.doctor.id = :doctorId",
                    Availability.class
            );
            q.setParameter("doctorId", doctorId);
            return q.getResultList();
        } finally {
            em.close();
        }
    }
}
