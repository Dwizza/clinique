package com.cliniquedigitale.controllers;

import com.cliniquedigitale.DTO.AvailabilityDTO;
import com.cliniquedigitale.Enums.Jour;
import com.cliniquedigitale.entities.Doctor;
import com.cliniquedigitale.service.AvailabilityService;
import com.cliniquedigitale.service.DoctorSevice;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.TextStyle;
import java.util.*;

@WebServlet("/patient/doctor")
public class PatientDoctorServlet extends HttpServlet {

    @Inject
    private DoctorSevice doctorService;

    @Inject
    private AvailabilityService availabilityService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/patient");
            return;
        }
        UUID doctorId;
        try {
            doctorId = UUID.fromString(idParam);
        } catch (IllegalArgumentException e) {
            response.sendRedirect(request.getContextPath() + "/patient");
            return;
        }

        Doctor doctor = doctorService.getDoctorById(doctorId);
        if (doctor == null) {
            response.sendRedirect(request.getContextPath() + "/patient");
            return;
        }

        int year;
        int month;
        try {
            year = Integer.parseInt(Optional.ofNullable(request.getParameter("year")).orElse(String.valueOf(LocalDate.now().getYear())));
            month = Integer.parseInt(Optional.ofNullable(request.getParameter("month")).orElse(String.valueOf(LocalDate.now().getMonthValue())));
        } catch (NumberFormatException ex) {
            year = LocalDate.now().getYear();
            month = LocalDate.now().getMonthValue();
        }
        YearMonth ym;
        try {
            ym = YearMonth.of(year, month);
        } catch (Exception e) {
            ym = YearMonth.now();
            year = ym.getYear();
            month = ym.getMonthValue();
        }

        List<AvailabilityDTO> slots = availabilityService.getAvailabilityByDoctorId(doctorId.toString());
        Map<Jour, List<String>> weekly = new EnumMap<>(Jour.class);
        for (AvailabilityDTO dto : slots) {
            if (dto.getJour() == null) continue;
            String label;
            if (dto.getHeureDebut() != null && dto.getHeureFin() != null) {
                label = String.format("%s - %s", dto.getHeureDebut(), dto.getHeureFin());
            } else {
                label = "Disponible";
            }
            weekly.computeIfAbsent(dto.getJour(), k -> new ArrayList<>()).add(label);
        }

        Set<DayOfWeek> availableDows = new HashSet<>();
        for (Jour j : weekly.keySet()) {
            availableDows.add(mapJourToDayOfWeek(j));
        }

        List<Map<String, Object>> dayCells = new ArrayList<>();
        LocalDate firstDay = ym.atDay(1);
        int daysInMonth = ym.lengthOfMonth();
        for (int d = 1; d <= daysInMonth; d++) {
            LocalDate date = ym.atDay(d);
            DayOfWeek dow = date.getDayOfWeek();
            boolean isAvailable = availableDows.contains(dow);
            Map<String, Object> cell = new HashMap<>();
            cell.put("day", d);
            cell.put("dow", dow.getValue()); // 1=Monday..7=Sunday
            cell.put("available", isAvailable);
            dayCells.add(cell);
        }

        String monthLabel = ym.getMonth().getDisplayName(TextStyle.FULL, Locale.FRENCH);
        LocalDate today = LocalDate.now();
        YearMonth prev = ym.minusMonths(1);
        YearMonth next = ym.plusMonths(1);

        request.setAttribute("doctor", doctor);
        request.setAttribute("weekly", weekly);
        request.setAttribute("year", year);
        request.setAttribute("month", month);
        request.setAttribute("monthLabel", monthLabel);
        request.setAttribute("daysInMonth", daysInMonth);
        request.setAttribute("firstDow", firstDay.getDayOfWeek().getValue());
        request.setAttribute("dayCells", dayCells);
        request.setAttribute("today", today);
        request.setAttribute("prevYear", prev.getYear());
        request.setAttribute("prevMonth", prev.getMonthValue());
        request.setAttribute("nextYear", next.getYear());
        request.setAttribute("nextMonth", next.getMonthValue());

        request.getRequestDispatcher("/WEB-INF/view/patient/doctor-availability.jsp").forward(request, response);
    }

    private DayOfWeek mapJourToDayOfWeek(Jour jour) {
        return switch (jour) {
            case LUNDI -> DayOfWeek.MONDAY;
            case MARDI -> DayOfWeek.TUESDAY;
            case MERCREDI -> DayOfWeek.WEDNESDAY;
            case JEUDI -> DayOfWeek.THURSDAY;
            case VENDREDI -> DayOfWeek.FRIDAY;
            case SAMEDI -> DayOfWeek.SATURDAY;
            case DIMANCHE -> DayOfWeek.SUNDAY;
        };
    }
}
