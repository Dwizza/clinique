package com.cliniquedigitale.controllers;

import com.cliniquedigitale.DTO.UserDTO;
import com.cliniquedigitale.Enums.Role;
import com.cliniquedigitale.service.AuthService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/auth/*")
public class AuthServlet extends HttpServlet {

    @Inject
    private AuthService authService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo();

        if (path == null || "/".equals(path) || path.isEmpty()) {
            request.getRequestDispatcher("/WEB-INF/view/auth/login.jsp").forward(request, response);
            return;
        }

        if ("/login".equals(path)) {
            request.getRequestDispatcher("/WEB-INF/view/auth/login.jsp").forward(request, response);
        } else if ("/register".equals(path)) {
            request.getRequestDispatcher("/WEB-INF/view/auth/register.jsp").forward(request, response);
        } else if ("/logout".equals(path)){
            HttpSession session = request.getSession();

            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/auth/login?logout=1");

        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null || "/".equals(path) || path.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        HttpSession session = request.getSession();

        if ("/login".equals(path)) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            UserDTO user = authService.Login( email, password );

            if ( user != null ) {
                session.setAttribute("user", user);
                switch(user.getRole()){
                    case ADMIN -> response.sendRedirect(request.getContextPath() + "/admin");
                    case PATIENT -> response.sendRedirect(request.getContextPath() + "/patient");
                    case DOCTOR ->  response.sendRedirect(request.getContextPath() + "/doctor");
                    case STAFF -> response.sendRedirect(request.getContextPath() + "/staff");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/auth/login?error=1");
            }

        } else if ("/register".equals(path)) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String cin = request.getParameter("cin");
            String naissanceStr = request.getParameter("naissance");
            String sexe = request.getParameter("sexe");
            String adresse = request.getParameter("adresse");
            String telephone = request.getParameter("telephone");
            String sang = request.getParameter("sang");


            if (name == null || name.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.length() < 6 ||
                cin == null || cin.trim().isEmpty() ||
                naissanceStr == null || naissanceStr.trim().isEmpty() ||
                sexe == null || sexe.trim().isEmpty() ||
                telephone == null || telephone.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/auth/register?error=validation");
                return;
            }

            LocalDate naissance;
            try {
                naissance = LocalDate.parse(naissanceStr);
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/auth/register?error=invaliddate");
                return;
            }

            UserDTO created = authService.registerPatient(name, email, password, cin, naissance, sexe, adresse, telephone, sang);
            if (created == null) {
                response.sendRedirect(request.getContextPath() + "/auth/register?error=exists");
                return;
            }

            response.sendRedirect(request.getContextPath() + "/auth/login?registered=1");

        }else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

}
