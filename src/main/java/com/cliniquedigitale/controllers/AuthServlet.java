package com.cliniquedigitale.controllers;

import com.cliniquedigitale.entities.User;
import com.cliniquedigitale.service.AuthService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/auth/*")
public class AuthServlet extends HttpServlet {

    @Inject
    private AuthService authService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        String path = request.getPathInfo();


        if (path == null || "/".equals(path) || "".equals(path)) {
            request.getRequestDispatcher("/WEB-INF/view/auth/login.jsp").forward(request, response);
            return;
        }

        if ("/login".equals(path)) {
            request.getRequestDispatcher("/WEB-INF/view/auth/login.jsp").forward(request, response);
        } else if ("/register".equals(path)) {
            request.getRequestDispatcher("/WEB-INF/view/auth/register.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null || "/".equals(path) || "".equals(path)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        HttpSession session = request.getSession();

        if ("/login".equals(path)) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            User user = authService.Login( email, password );


            if (user != null ) {
                session.setAttribute("user", email);
                response.sendRedirect(request.getContextPath() + "/");
            } else {
                response.sendRedirect(request.getContextPath() + "/auth/login?error=1");
            }

        } else if ("/register".equals(path)) {
            String name = request.getParameter("name");
             String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirm = request.getParameter("confirm");
            


            if (email == null || email.isBlank() || password == null || password.length() < 6 || !password.equals(confirm)) {
                response.sendRedirect(request.getContextPath() + "/auth/register?error=1");
                return;
            }

            session.setAttribute("registeredEmail", email);
            session.setAttribute("registeredPassword", password);
            session.setAttribute("registeredName", name);

            response.sendRedirect(request.getContextPath() + "/auth/login?registered=1");

        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

}
