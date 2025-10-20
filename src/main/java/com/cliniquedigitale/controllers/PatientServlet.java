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
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;


@WebServlet(urlPatterns = {"/patient", "/patient/doctors"})
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

        String servletPath = request.getServletPath();
        if ("/patient/doctors".equals(servletPath)) {
            handleDoctorsBySpeciality(request, response);
            return;
        }

        String searchTerm = request.getParameter("search");
        String specialityIdParam = request.getParameter("speciality");
        List<Doctor> doctors;

        List<Specialty> specialties = specialtyService.getAll();
        request.setAttribute("specialties", specialties);

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

    private void handleDoctorsBySpeciality(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String specialityId = request.getParameter("specialityId");
        List<Map<String, Object>> out = new ArrayList<>();
        try {
            if (specialityId != null && !specialityId.isBlank()) {
                UUID id = UUID.fromString(specialityId);
                List<Doctor> doctors = doctorService.getDoctorsBySpeciality(id);
                for (Doctor d : doctors) {
                    Map<String, Object> dto = new HashMap<>();
                    dto.put("id", d.getId());
                    dto.put("user", Map.of("name", d.getUser() != null ? d.getUser().getName() : ""));
                    out.add(dto);
                }
            }
            response.setContentType("application/json;charset=UTF-8");
            try (PrintWriter w = response.getWriter()) {
                w.write(new Gson().toJson(out));
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json;charset=UTF-8");
            try (PrintWriter w = response.getWriter()) {
                w.write("[]");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


    }
}
