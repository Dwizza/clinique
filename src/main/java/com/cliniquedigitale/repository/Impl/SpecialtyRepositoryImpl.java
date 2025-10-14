package com.cliniquedigitale.repository.Impl;

import com.cliniquedigitale.config.JpaUtil;
import com.cliniquedigitale.entities.Specialty;
import com.cliniquedigitale.repository.SpecialtyRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class SpecialtyRepositoryImpl implements SpecialtyRepository {

    @Override
    public Specialty save(Specialty specialty) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(specialty);
            em.getTransaction().commit();
            return specialty;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Specialty> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT s FROM Specialty s ORDER BY s.department.name, s.name", Specialty.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Specialty findByNameAndDepartment(String name, UUID departmentId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Specialty> q = em.createQuery(
                    "SELECT s FROM Specialty s WHERE UPPER(s.name) = :name AND s.department.id = :depId",
                    Specialty.class
            );
            q.setParameter("name", name == null ? null : name.toUpperCase());
            q.setParameter("depId", departmentId);
            return q.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public Specialty findById(UUID specialtyId) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            TypedQuery<Specialty> q = em.createQuery("SELECT s FROM Specialty s WHERE s.id = :id", Specialty.class);
            q.setParameter("id", specialtyId);
            return q.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }
}

