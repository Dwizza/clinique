package com.cliniquedigitale.controllers;

import com.cliniquedigitale.DTO.AvailabilityDTO;
import com.cliniquedigitale.DTO.Response.ResponseUserDTO;
import com.cliniquedigitale.Enums.Jour;
import com.cliniquedigitale.Enums.Role;
import com.cliniquedigitale.Enums.StatutDispo;
import com.cliniquedigitale.service.AvailabilityService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalTime;
import java.util.*;

@WebServlet("/doctor/availability/*")
public class AvailabilityServlet extends HttpServlet {

    @Inject
    private AvailabilityService availabilityService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{

        HttpSession session = request.getSession(false);
        ResponseUserDTO user = session != null ? (ResponseUserDTO) session.getAttribute("user") : null;
        if (user == null || user.getRole() != Role.DOCTOR) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        List<AvailabilityDTO> availabilities = availabilityService.getAvailabilityByEmail(user.getEmail());
        request.setAttribute("availabilities", availabilities);
        request.getRequestDispatcher("/WEB-INF/view/doctor/availability.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null) path = "";

        try {
            if ("/save-daily".equals(path)) {
                handleSaveDaily(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            Throwable root = e;
            while (root.getCause() != null) root = root.getCause();
            String msg = root.getMessage() != null ? root.getMessage() : e.toString();
            request.setAttribute("errorMessage", msg);
            request.getRequestDispatcher("/WEB-INF/view/doctor/availability.jsp").forward(request, response);
        }
    }

    private void handleSaveDaily(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        ResponseUserDTO user = session != null ? (ResponseUserDTO) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        if (user.getRole() != Role.DOCTOR) {
            response.sendRedirect(request.getContextPath() + "/auth/login?error=role");
            return;
        }
        final String email = user.getEmail();

        Map<String, Jour> map = new LinkedHashMap<>();
        map.put("lundi", Jour.LUNDI);
        map.put("mardi", Jour.MARDI);
        map.put("mercredi", Jour.MERCREDI);
        map.put("jeudi", Jour.JEUDI);
        map.put("vendredi", Jour.VENDREDI);
        map.put("samedi", Jour.SAMEDI);

        List<AvailabilityDTO> availabilityDTOs = new ArrayList<>();
        Set<Jour> enabledDays = EnumSet.noneOf(Jour.class);

        for (Map.Entry<String, Jour> entry : map.entrySet()) {
            String key = entry.getKey();
            Jour jour = entry.getValue();
            String enabled = request.getParameter(key + "_enabled");
            if (enabled == null) continue;
            enabledDays.add(jour);

            String[] starts = request.getParameterValues(key + "_debut[]");
            String[] ends = request.getParameterValues(key + "_fin[]");
            if (starts == null || ends == null || starts.length == 0 || starts.length != ends.length) continue;

            for (int i = 0; i < starts.length; i++) {
                try {
                    LocalTime s = LocalTime.parse(starts[i]);
                    LocalTime e = LocalTime.parse(ends[i]);
                    if (!e.isAfter(s)) continue;
                    AvailabilityDTO dto = new AvailabilityDTO();
                    dto.setJour(jour);
                    dto.setHeureDebut(s);
                    dto.setHeureFin(e);
                    dto.setStatut(StatutDispo.AVAILABLE);
                    availabilityDTOs.add(dto);
                } catch (Exception ignored) {}
            }
        }

        EnumSet<Jour> allDays = EnumSet.of(Jour.LUNDI, Jour.MARDI, Jour.MERCREDI, Jour.JEUDI, Jour.VENDREDI, Jour.SAMEDI);
        EnumSet<Jour> disabledDays = EnumSet.copyOf(allDays);
        disabledDays.removeAll(enabledDays);

        if (enabledDays.isEmpty()) {
            availabilityService.setOnLeaveDays(email, disabledDays);
            request.setAttribute("successMessage", "Tous les jours (lun-sam) ont été marqués comme congé (ON_LEAVE).");
            request.setAttribute("availabilities", availabilityService.getAvailabilityByEmail(email));
            request.getRequestDispatcher("/WEB-INF/view/doctor/availability.jsp").forward(request, response);
            return;
        }

        availabilityService.saveDaily(email, availabilityDTOs);
        if (!disabledDays.isEmpty()) availabilityService.setOnLeaveDays(email, disabledDays);

        request.setAttribute("successMessage", "Disponibilités enregistrées et jours non cochés (lun-sam) marqués en congé.");
        request.setAttribute("availabilities", availabilityService.getAvailabilityByEmail(email));
        request.getRequestDispatcher("/WEB-INF/view/doctor/availability.jsp").forward(request, response);
    }
}
