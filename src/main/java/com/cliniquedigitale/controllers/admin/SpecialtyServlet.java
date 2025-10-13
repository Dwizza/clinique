package com.cliniquedigitale.controllers.admin;

import com.cliniquedigitale.DTO.SpecialtyDTO;
import com.cliniquedigitale.service.SpecialtyService;
import jakarta.inject.Inject;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.UUID;

@WebServlet("/admin/specialty/*")
public class SpecialtyServlet extends HttpServlet {

    @Inject
    private SpecialtyService specialtyService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String path = request.getPathInfo();
        if (path == null || path.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        if ("/create".equals(path)) {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String departmentId = request.getParameter("departmentId");
            try {
                SpecialtyDTO dto = new SpecialtyDTO();
                dto.setName(name);
                dto.setDescription(description);
                dto.setDepartmentId(UUID.fromString(departmentId));
                specialtyService.create(dto);
                response.sendRedirect(request.getContextPath() + "/admin");
//                return;
            } catch (IllegalArgumentException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
                return;
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
