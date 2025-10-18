package com.cliniquedigitale.repository.Impl;

import com.cliniquedigitale.config.JpaUtil;
import com.cliniquedigitale.entities.Appointment;
import com.cliniquedigitale.entities.Doctor;
import com.cliniquedigitale.repository.AppointmentRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.time.LocalDate;
import java.util.List;

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
}
