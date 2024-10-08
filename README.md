# CITS4009

# CITS4009 Project 1: Probabilistic Inference in Bayesian Networks

This project focuses on the application of probabilistic inference in Bayesian Networks. The goal is to analyze how probabilistic models can be used to infer the likelihood of different outcomes based on a set of variables and dependencies between them. The project is divided into multiple sections, each exploring different aspects of Bayesian inference and its real-world applications.

## Project Overview

Bayesian Networks are graphical models that represent probabilistic relationships among a set of variables. This project demonstrates the use of these networks in probabilistic inference, where we aim to compute posterior probabilities given observed evidence. The project focuses on various techniques for performing inference and the evaluation of these techniques.

### Key Concepts:
- **Bayesian Networks**: Graphical models representing dependencies among variables.
- **Inference Techniques**: Methods for computing posterior probabilities.
- **Conditional Probability Tables (CPTs)**: Used to define the probability distribution of each node in the network.
- **Markov Blanket**: The set of nodes that renders the target node conditionally independent of the rest of the network.

## Sections Covered

### 1. Introduction to Bayesian Networks
This section introduces Bayesian Networks and their importance in modeling probabilistic relationships. It provides an overview of how these networks are constructed using directed acyclic graphs, where each node represents a variable, and the edges represent conditional dependencies.

### 2. Probabilistic Inference
The core focus of the project, this section explores various techniques for performing inference in Bayesian Networks. Techniques covered include:
- **Variable Elimination**: A method for marginalizing out variables to compute the posterior distribution of a query variable.
- **Sampling Methods**: Approaches like rejection sampling and likelihood weighting for approximate inference.

### 3. Real-World Application
In this section, we apply Bayesian Networks to a real-world problem, such as medical diagnosis or risk assessment. The goal is to demonstrate how these models can be used to compute probabilities given evidence, providing insights into decision-making under uncertainty.

### 4. Evaluation of Inference Techniques
This section compares the accuracy and efficiency of different inference methods. We evaluate each technique on several performance metrics, including computational complexity, accuracy of results, and scalability.

## Usage Instructions

To run the code associated with this project:
1. Ensure that the required libraries, such as `numpy` and `networkx`, are installed.
2. Load the Bayesian network structure and Conditional Probability Tables (CPTs).
3. Use the provided functions to perform inference on the network, supplying observed evidence as input.
4. The output will display the posterior probabilities for the query variables.

## Conclusion

This project showcases the power of Bayesian Networks in performing probabilistic inference, providing a framework for decision-making under uncertainty. By exploring different inference techniques and their applications, we gain valuable insights into how these methods can be used in fields such as AI, healthcare, and risk management.

# CITS4009 - Project 2: Secure Programming Practices

This project is focused on implementing secure programming practices in web development. It investigates vulnerabilities that often affect web applications and demonstrates how to mitigate these risks using secure coding techniques. By applying these techniques, the project aims to protect web applications from common threats such as SQL injection, cross-site scripting (XSS), and cross-site request forgery (CSRF).

## Project Overview

The project addresses various security issues that web developers may encounter and highlights best practices for preventing exploitation. Several key vulnerabilities and defenses are explored, with a focus on practical application in real-world web development environments. The project demonstrates:
- **Identification of Security Vulnerabilities**: Identifying common weaknesses in web applications, such as input validation failures and improper session handling.
- **Implementation of Secure Coding Techniques**: Introducing safe development practices to mitigate risks associated with these vulnerabilities.
- **Testing for Vulnerabilities**: Methods for testing web applications to ensure they are secure against known threats.
- **Mitigation Strategies**: Detailed exploration of how to eliminate or reduce the impact of security vulnerabilities.

## Key Vulnerabilities Addressed

1. **SQL Injection**: One of the most dangerous web vulnerabilities, SQL injection allows an attacker to manipulate a web application's database. This project demonstrates how to prevent SQL injection using parameterized queries and prepared statements.
   
2. **Cross-Site Scripting (XSS)**: XSS occurs when an attacker injects malicious scripts into content that other users see. This project discusses methods for preventing XSS, such as proper input validation and output encoding.
   
3. **Cross-Site Request Forgery (CSRF)**: CSRF exploits the trust that a web application has in the user's browser. This project explains how to implement anti-CSRF tokens to protect web forms from being used maliciously.

4. **Session Management Vulnerabilities**: Insecure session management can lead to attacks such as session hijacking. The project covers secure session handling practices, including setting secure cookies, using HTTPS, and implementing proper session timeouts.

## Features

- **Input Validation and Sanitization**: Properly validates and sanitizes all user inputs to prevent injection attacks.
- **Output Encoding**: Ensures that output is properly encoded, which prevents malicious scripts from being executed.
- **CSRF Tokens**: Implements CSRF tokens to safeguard sensitive operations.
- **Secure Session Management**: Utilizes secure session handling techniques, ensuring that user sessions are protected from hijacking.
- **Error Handling**: Secure error-handling mechanisms are implemented to prevent leakage of sensitive information to users or attackers.

## Secure Programming Practices

The project demonstrates the following secure programming practices:
- **Defense in Depth**: Multiple layers of security are applied, ensuring that even if one defense fails, others are still in place to protect the application.
- **Least Privilege**: The principle of least privilege is adhered to by limiting access rights for users and processes to the bare minimum necessary for functionality.
- **Fail-Secure Defaults**: Default configurations and behavior are set to deny access unless explicitly allowed, ensuring that errors do not expose vulnerabilities.
- **Security Auditing and Logging**: Implements logging mechanisms to track potentially malicious activity, helping with incident detection and response.

## Testing for Security

The project outlines various testing methods to ensure that the implemented defenses work as intended:
- **Penetration Testing**: Simulates attacks on the web application to discover vulnerabilities before they can be exploited by malicious users.
- **Automated Security Scanning**: Uses tools to scan the web application for known vulnerabilities such as XSS and SQL injection.
- **Manual Code Review**: Reviews the codebase for security issues, ensuring that the correct secure programming techniques are applied.

## Conclusion

This project provides a comprehensive look at secure programming practices that are critical for developing robust and secure web applications. By identifying and mitigating common vulnerabilities, the project demonstrates how to protect web applications from attacks and improve overall security.

## Files in this Repository

- `index.html`: The main HTML file containing the web application's interface.
- `secure_app.js`: JavaScript file implementing secure coding practices in the application logic.
- `CSRF_protection.php`: PHP file demonstrating the implementation of CSRF tokens in form handling.
- `README.md`: This documentation file providing an overview of the project.
