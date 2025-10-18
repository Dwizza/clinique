package com.cliniquedigitale.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet("/doctor/*")
public class DoctorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String path = request.getPathInfo();

        if ("/availability".equals(path)){
            request.getRequestDispatcher("/WEB-INF/view/doctor/availability.jsp").forward(request, response);
        } else if ("/dashboard".equals(path)) {
            request.getRequestDispatcher("/WEB-INF/view/doctor/dashboard.jsp").forward(request, response);
        } else if ("/appointments".equals(path)) {
            request.getRequestDispatcher("/WEB-INF/view/doctor/appointment.jsp").forward(request, response);
        }
    }
}
