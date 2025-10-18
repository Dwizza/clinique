package com.cliniquedigitale.controllers;

import com.cliniquedigitale.DTO.AvailabilityDTO;
import com.cliniquedigitale.DTO.Response.ResponseUserDTO;
import com.cliniquedigitale.Enums.Role;
import com.cliniquedigitale.entities.Appointment;
import com.cliniquedigitale.service.AppointmentService;
import com.cliniquedigitale.service.AvailabilityService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalTime;
import java.util.List;

@WebServlet("/doctor/*")
public class DoctorServlet extends HttpServlet {

    @Inject
    private AvailabilityService availabilityService;

    @Inject
    private AppointmentService appointmentService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null) path = "";

        switch (path) {
            case "/availability" -> request.getRequestDispatcher("/WEB-INF/view/doctor/availability.jsp").forward(request, response);
            case "/appointments" -> request.getRequestDispatcher("/WEB-INF/view/doctor/appointment.jsp").forward(request, response);
            case "/dashboard", "", "/" -> {
                HttpSession session = request.getSession(false);
                ResponseUserDTO user = session != null ? (ResponseUserDTO) session.getAttribute("user") : null;
                if (user == null || user.getRole() != Role.DOCTOR) {
                    response.sendRedirect(request.getContextPath() + "/auth/login");
                    return;
                }
                final String email = user.getEmail();

                List<AvailabilityDTO> todayAvailabilities = availabilityService.getTodayAvailabilityByEmail(email);
                List<Appointment> todayAppointments = appointmentService.getTodayAppointmentsByEmail(email);

                long totalMinutes = 0;
                for (AvailabilityDTO dto : todayAvailabilities) {
                    LocalTime s = dto.getHeureDebut();
                    LocalTime e = dto.getHeureFin();
                    if (s != null && e != null && e.isAfter(s)) {
                        totalMinutes += Duration.between(s, e).toMinutes();
                    }
                }
                long hours = totalMinutes / 60;
                long minutes = totalMinutes % 60;
                String availableHoursLabel = minutes == 0 ? hours + "h" : hours + "h " + minutes + "m";

                int appointmentsCount = todayAppointments != null ? todayAppointments.size() : 0;

                String name = user.getName() != null ? user.getName() : "Docteur";
                String initials = computeInitials(name);

                request.setAttribute("user", user);
                request.setAttribute("doctorName", name);
                request.setAttribute("avatarInitials", initials);
                request.setAttribute("todayAvailabilities", todayAvailabilities);
                request.setAttribute("appointments", todayAppointments);
                request.setAttribute("appointmentsCount", appointmentsCount);
                request.setAttribute("availableHoursLabel", availableHoursLabel);
                request.setAttribute("notesCount", 0);
                request.setAttribute("monthConsultations", appointmentsCount); // placeholder simple

                request.getRequestDispatcher("/WEB-INF/view/doctor/dashboard.jsp").forward(request, response);
            }
            default -> response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private String computeInitials(String name) {
        if (name == null || name.isBlank()) return "DR";
        String[] parts = name.trim().split("\\s+");
        StringBuilder sb = new StringBuilder();
        for (String p : parts) {
            if (!p.isBlank() && sb.length() < 2) sb.append(Character.toUpperCase(p.charAt(0)));
            if (sb.length() == 2) break;
        }
        if (sb.isEmpty()) return "DR";
        return sb.toString();
    }
}
