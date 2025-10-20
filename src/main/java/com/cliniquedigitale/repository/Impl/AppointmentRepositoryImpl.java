package com.cliniquedigitale.repository.Impl;

import com.cliniquedigitale.config.JpaUtil;
import com.cliniquedigitale.entities.Appointment;
import com.cliniquedigitale.entities.Doctor;
import com.cliniquedigitale.entities.Patient;
import com.cliniquedigitale.repository.AppointmentRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class AppointmentRepositoryImpl implements AppointmentRepository {
    @Override
    public List<Appointment> findByDoctorAndDate(Doctor doctor, LocalDate date) {
        if (doctor == null || doctor.getId() == null || date == null) return List.of();
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Appointment> q = em.createQuery(
                    "SELECT a FROM Appointment a " +
                    "JOIN FETCH a.patient p " +
                    "JOIN FETCH p.user u " +
                    "WHERE a.doctor.id = :doctorId AND a.date = :date ORDER BY a.hour ASC",
                    Appointment.class
            );
            q.setParameter("doctorId", doctor.getId());
            q.setParameter("date", date);
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Appointment save(Appointment appointment) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            if (appointment.getDoctor() != null && appointment.getDoctor().getId() != null) {
                appointment.setDoctor(em.getReference(Doctor.class, appointment.getDoctor().getId()));
            }
            if (appointment.getPatient() != null && appointment.getPatient().getId() != null) {
                appointment.setPatient(em.getReference(Patient.class, appointment.getPatient().getId()));
            }
            if (appointment.getId() == null) {
                em.persist(appointment);
            } else {
                appointment = em.merge(appointment);
            }
            em.getTransaction().commit();
            return appointment;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public Appointment findByDoctorDateHour(Doctor doctor, LocalDate date, LocalTime hour) {
        if (doctor == null || doctor.getId() == null || date == null || hour == null) return null;
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Appointment> q = em.createQuery(
                    "SELECT a FROM Appointment a WHERE a.doctor.id = :doctorId AND a.date = :date AND a.hour = :hour",
                    Appointment.class
            );
            q.setParameter("doctorId", doctor.getId());
            q.setParameter("date", date);
            q.setParameter("hour", hour);
            return q.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public Appointment findById(UUID id) {
        if (id == null) return null;
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Appointment> q = em.createQuery(
                    "SELECT a FROM Appointment a " +
                    "JOIN FETCH a.patient p " +
                    "JOIN FETCH p.user u " +
                    "JOIN FETCH a.doctor d " +
                    "WHERE a.id = :id",
                    Appointment.class
            );
            q.setParameter("id", id);
            return q.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }
}
