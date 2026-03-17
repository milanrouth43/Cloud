# Docker Networking Practical

## Objective
Demonstrate container communication differences between Docker's default bridge network and a user-defined custom bridge network.

## Steps Completed
1. **Default Bridge Test:** * Deployed two containers (`app1`, `app2`) on the default bridge.
   * Attempted to ping `app1` from `app2` using the container name. 
   * **Result:** Failed. Proved that the default bridge lacks automatic DNS resolution.
2. **Custom Bridge Test:** * Created a user-defined network using `docker network create my-custom-net`.
   * Deployed two new containers (`app3`, `app4`) attached to this custom network.
   * Attempted to ping `app3` from `app4` using the container name.
   * **Result:** Succeeded. Proved that user-defined networks provide built-in DNS resolution for container-to-container communication.