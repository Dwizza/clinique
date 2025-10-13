package com.cliniquedigitale.repository.Impl;

import com.cliniquedigitale.config.JpaUtil;
import com.cliniquedigitale.entities.Department;
import com.cliniquedigitale.repository.DepartmentRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class DepartmentRepositoryImpl implements DepartmentRepository {

    @Override
    public Department findDepartment(String name){
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Department> q = em.createQuery(
                    "SELECT d FROM Department d WHERE UPPER(d.name) = :name", Department.class
            );
            q.setParameter("name", name == null ? null : name.toUpperCase());
            return q.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public Department save(Department department){
        EntityManager em = JpaUtil.getEntityManager();
        try{
            em.getTransaction().begin();
            em.persist(department);
            em.getTransaction().commit();
            return department;
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
    public List<Department> findAll(){
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT d FROM Department d ORDER BY d.name", Department.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Department findById(UUID id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Department.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public Department update(Department department) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Department merged = em.merge(department);
            em.getTransaction().commit();
            return merged;
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
    public boolean deleteById(UUID id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            Department entity = em.find(Department.class, id);
            if (entity == null) return false;
            em.getTransaction().begin();
            em.remove(entity);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }
}
