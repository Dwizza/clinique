package com.cliniquedigitale.controllers;

import com.cliniquedigitale.entities.Doctor;
import com.cliniquedigitale.entities.Specialty;
import com.cliniquedigitale.service.DoctorSevice;
import com.cliniquedigitale.service.PatientService;
import com.cliniquedigitale.service.SpecialtyService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.UUID;


@WebServlet("/patient")
public class PatientServlet extends HttpServlet {

    @Inject
    private PatientService patientService;

    @Inject
    private DoctorSevice doctorService;

    @Inject
    private SpecialtyService specialtyService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchTerm = request.getParameter("search");
        String specialityIdParam = request.getParameter("speciality");
        List<Doctor> doctors;

        // Charger toutes les spécialités pour le select
        List<Specialty> specialties = specialtyService.getAll();
        request.setAttribute("specialties", specialties);

        // Filtrer les médecins selon les critères
        if (specialityIdParam != null && !specialityIdParam.trim().isEmpty()) {
            try {
                UUID specialityId = UUID.fromString(specialityIdParam);
                doctors = doctorService.getDoctorsBySpeciality(specialityId);
                request.setAttribute("selectedSpeciality", specialityIdParam);
            } catch (IllegalArgumentException e) {
                doctors = doctorService.getAllDoctors();
            }
        } else if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            doctors = doctorService.searchDoctors(searchTerm);
            request.setAttribute("searchTerm", searchTerm);
        } else {
            doctors = doctorService.getAllDoctors();
        }

        request.setAttribute("doctors", doctors);
        request.getRequestDispatcher("/WEB-INF/view/patient/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


    }
}
