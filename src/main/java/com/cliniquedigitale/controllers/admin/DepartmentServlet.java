package com.cliniquedigitale.controllers.admin;

import com.cliniquedigitale.DTO.DepartmentDTO;
import com.cliniquedigitale.service.DepartmentService;
import jakarta.inject.Inject;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.UUID;


@WebServlet("/admin/department/*")
public class DepartmentServlet extends HttpServlet {

    @Inject
    private DepartmentService departmentService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String path = request.getPathInfo();

        if (path == null || path.isEmpty() || "/".equals(path)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        if ("/create".equals(path)){
            String name = request.getParameter("name");
            String description = request.getParameter("description");

            DepartmentDTO depDTO = new DepartmentDTO();
            depDTO.setName(name);
            depDTO.setDescription(description);

            DepartmentDTO departDTO = departmentService.create(depDTO);

            if (departDTO != null) {
                response.sendRedirect(request.getContextPath() + "/admin");
                return;
            }
        } else if ("/edit".equals(path)) {
            String idParam = request.getParameter("id");
            String name = request.getParameter("name");
            String description = request.getParameter("description");

            try {
                UUID id = UUID.fromString(idParam);
                DepartmentDTO depDTO = new DepartmentDTO();
                depDTO.setId(id);
                depDTO.setName(name);
                depDTO.setDescription(description);

                DepartmentDTO updated = departmentService.update(depDTO);
                if (updated != null) {
                    response.sendRedirect(request.getContextPath() + "/admin");
                    return;
                }
            } catch (IllegalArgumentException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
                return;
            }
        } else if ("/delete".equals(path)) {
            String idParam = request.getParameter("id");
            try {
                UUID id = UUID.fromString(idParam);
                boolean ok = departmentService.delete(id);
                if (ok) {
                    response.sendRedirect(request.getContextPath() + "/admin");
                    return;
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Department introuvable");
                    return;
                }
            } catch (IllegalArgumentException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
                return;
            } catch (IllegalStateException e) {
                response.sendError(HttpServletResponse.SC_CONFLICT, e.getMessage());
                return;
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }
}
