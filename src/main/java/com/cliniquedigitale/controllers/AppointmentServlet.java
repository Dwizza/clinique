package com.cliniquedigitale.controllers;

import com.cliniquedigitale.service.AppointmentService;
import com.google.gson.Gson;
import jakarta.inject.Inject;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.cliniquedigitale.Enums.TypeAppointment;
import com.cliniquedigitale.DTO.Response.ResponseUserDTO;

@WebServlet(urlPatterns = {"/appointment", "/patient/appointments/*"})
public class AppointmentServlet extends HttpServlet {

    @Inject
    private AppointmentService appointmentService;

    private static final DateTimeFormatter TIME_FMT = DateTimeFormatter.ofPattern("HH:mm");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String servletPath = req.getServletPath();
        if ("/appointment".equals(servletPath)) {
            String action = req.getParameter("action");
            if ("slots".equalsIgnoreCase(action)) {
                handleSlots(req, resp);
                return;
            }
        }
        resp.sendError(HttpServletResponse.SC_NOT_FOUND);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String servletPath = req.getServletPath();
        if ("/patient/appointments".equals(servletPath)) {
            String path = req.getPathInfo();
            if (path == null) { resp.sendError(HttpServletResponse.SC_NOT_FOUND); return; }
            switch (path) {
                case "/book" -> handleBook(req, resp);
                case "/cancel" -> handleCancel(req, resp);
                default -> resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
            return;
        }
        resp.sendError(HttpServletResponse.SC_NOT_FOUND);
    }

    private void handleSlots(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String doctorIdParam = req.getParameter("doctorId");
        String dateParam = req.getParameter("date");
        if (doctorIdParam == null || doctorIdParam.isBlank() || dateParam == null || dateParam.isBlank()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            writeJson(resp, List.of());
            return;
        }
        try {
            UUID doctorId = UUID.fromString(doctorIdParam);
            LocalDate date = LocalDate.parse(dateParam);
            List<LocalTime> slots = appointmentService.getAvailableSlots(doctorId, date);
            List<String> out = new ArrayList<>();
            for (LocalTime t : slots) out.add(t.format(TIME_FMT));
            writeJson(resp, out);
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            writeJson(resp, List.of());
        }
    }

    private void handleBook(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        ResponseUserDTO user = (ResponseUserDTO) req.getSession().getAttribute("user");
        if (user == null) { resp.sendRedirect(req.getContextPath() + "/auth/login"); return; }
        String doctorIdParam = req.getParameter("doctorId");
        String dateParam = req.getParameter("date");
        String timeParam = req.getParameter("time");
        String typeParam = req.getParameter("type");
        try {
            UUID doctorId = UUID.fromString(doctorIdParam);
            LocalDate date = LocalDate.parse(dateParam);
            LocalTime time = LocalTime.parse(timeParam, TIME_FMT);
//            String typeNormalized = typeParam != null && typeParam.equalsIgnoreCase("CONTROLE") ? "SUIVI" : typeParam;
            TypeAppointment type = TypeAppointment.valueOf(typeParam);
            appointmentService.bookAppointment(doctorId, user.getEmail(), date, time, type);
            System.out.println("dazt");
            resp.sendRedirect(req.getContextPath() + "/patient?booked=1");
        } catch (IllegalArgumentException e) {
            resp.sendRedirect(req.getContextPath() + "/patient?error=book&reason=" + mapReason(e.getMessage()));
        } catch (SecurityException e) {
            resp.sendRedirect(req.getContextPath() + "/patient?error=book&reason=forbidden");
        } catch (Exception e) {
            String reason = detectDbReason(e);
            resp.sendRedirect(req.getContextPath() + "/patient?error=book&reason=" + reason);
        }
    }

    private String mapReason(String msg) {
        if (msg == null) return "unknown";
        String m = msg.toLowerCase();
        if (m.contains("param") || m.contains("manquant")) return "params";
        if (m.contains("docteur") && m.contains("introuvable")) return "doctor";
        if (m.contains("patient") && m.contains("introuvable")) return "patient";
        if (m.contains("créneau") && (m.contains("non disponible") || m.contains("déjà réservé"))) return "slot";
        if (m.contains("délai")) return "time";
        return "unknown";
    }

    private String detectDbReason(Throwable e) {
        Throwable cur = e;
        while (cur != null) {
            String cls = cur.getClass().getName();
            String msg = String.valueOf(cur.getMessage()).toLowerCase();
            if (msg.contains("sqlstate: 23503") || msg.contains("foreign key constraint") || msg.contains("violates foreign key constraint")) {
                return "fk";
            }
            if (msg.contains("sqlstate: 23505") || msg.contains("duplicate") || msg.contains("unique constraint")) {
                return "unique";
            }
            if (cls.contains("DateTimeParseException")) return "params";
            cur = cur.getCause();
        }
        return "unknown";
    }

    private void handleCancel(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        ResponseUserDTO user = (ResponseUserDTO) req.getSession().getAttribute("user");
        if (user == null) { resp.sendRedirect(req.getContextPath() + "/auth/login"); return; }
        String apptIdParam = req.getParameter("appointmentId");
        try {
            UUID apptId = UUID.fromString(apptIdParam);
            appointmentService.cancelAppointment(apptId, user.getEmail());
            resp.sendRedirect(req.getContextPath() + "/patient?canceled=1");
        } catch (IllegalArgumentException e) {
            resp.sendRedirect(req.getContextPath() + "/patient?error=cancel&reason=" + mapReason(e.getMessage()));
        } catch (SecurityException e) {
            resp.sendRedirect(req.getContextPath() + "/patient?error=cancel&reason=forbidden");
        } catch (Exception e) {
            String reason = detectDbReason(e);
            resp.sendRedirect(req.getContextPath() + "/patient?error=cancel&reason=" + reason);
        }
    }

    private void writeJson(HttpServletResponse resp, Object payload) throws IOException {
        resp.setContentType("application/json;charset=UTF-8");
        try (PrintWriter w = resp.getWriter()) {
            w.write(new Gson().toJson(payload));
        }
    }
}
