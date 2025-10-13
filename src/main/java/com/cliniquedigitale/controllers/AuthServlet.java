package com.cliniquedigitale.controllers;

import com.cliniquedigitale.DTO.Request.RequestPatientDTO;
import com.cliniquedigitale.DTO.Request.RequestUserDTO;
import com.cliniquedigitale.DTO.Response.ResponseUserDTO;
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
        if (path == null || path.isEmpty() || "/".equals(path)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        HttpSession session = request.getSession();

        if ("/login".equals(path)) {
            handleLogin(request, response, session);

        } else if ("/register".equals(path)) {
            handleRegister(request, response);

        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String cin = request.getParameter("cin");
        String naissanceStr = request.getParameter("naissance");
        String sexe = request.getParameter("sexe");
        String adresse = request.getParameter("adresse");
        String telephone = request.getParameter("telephone");
        String sang = request.getParameter("sang");

        if (isInvalid(name, email, password, cin, naissanceStr, sexe, telephone)) {
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

        RequestUserDTO requestUserDto = new RequestUserDTO();
        requestUserDto.setName(name);
        requestUserDto.setEmail(email);
        requestUserDto.setPassword(password);
        requestUserDto.setRole(Role.PATIENT);

        RequestPatientDTO requestPatientDTO = new RequestPatientDTO();
        requestPatientDTO.setCin(cin);
        requestPatientDTO.setNaissance(naissance);
        requestPatientDTO.setSexe(sexe);
        requestPatientDTO.setAdresse(adresse);
        requestPatientDTO.setTelephone(telephone);
        requestPatientDTO.setSang(sang);


        ResponseUserDTO created = authService.registerPatient(requestUserDto, requestPatientDTO);

        if (created == null) {
            response.sendRedirect(request.getContextPath() + "/auth/register?error=exists");
        } else {
            response.sendRedirect(request.getContextPath() + "/auth/login?registered=1");
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/auth/login?error=missing");
            return;
        }

        RequestUserDTO credentials = new RequestUserDTO();
        credentials.setEmail(email);
        credentials.setPassword(password);

        ResponseUserDTO user = authService.Login(credentials);

        if (user != null) {
            session.setAttribute("user", user);

            switch (user.getRole()) {
                case ADMIN -> response.sendRedirect(request.getContextPath() + "/admin");
                case PATIENT -> response.sendRedirect(request.getContextPath() + "/patient");
                case DOCTOR -> response.sendRedirect(request.getContextPath() + "/doctor");
                case STAFF -> response.sendRedirect(request.getContextPath() + "/staff");
                default -> response.sendRedirect(request.getContextPath() + "/auth/login?error=role");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/auth/login?error=1");
        }
    }

    private boolean isInvalid(String name, String email, String password, String cin, String naissance, String sexe, String telephone) {
        return name == null || name.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.length() < 6
                || cin == null || cin.trim().isEmpty()
                || naissance == null || naissance.trim().isEmpty()
                || sexe == null || sexe.trim().isEmpty()
                || telephone == null || telephone.trim().isEmpty();
    }


}
