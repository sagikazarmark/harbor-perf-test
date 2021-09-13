
### Harbor Performance Testing Report


| API | Avg | Min | Med | Max | P(90) | P(95) | Success Rate | Iterations Rate |
|-----|-----|-----|-----|-----|-------|-------|--------------|-----------------|
| get-catalog | 3.17s | 2.09s | 3.35s | 3.77s | 3.62s | 3.63s | 100% | 29.35/s |
| list-artifact-tags | 152.5ms | 48.03ms | 154.12ms | 293.75ms | 211.16ms | 258.07ms | 100% | 599.52/s |
| list-artifacts | 8.17s | 13.31ms | 8.48s | 18.09s | 11.3s | 12.64s | 49.5% | 11.05/s |
| list-audit-logs | 3.81s | 775.69ms | 3.46s | 8.06s | 6.89s | 7.55s | 100% | 21.23/s |
| list-project-logs | 1.41s | 679.87ms | 1.4s | 2.05s | 1.76s | 1.78s | 100% | 66.71/s |
| list-project-members | 95.54ms | 15.97ms | 85.93ms | 195.62ms | 171.48ms | 182.93ms | 100% | 994.41/s |
| list-projects | 704.58ms | 113.04ms | 393.78ms | 1.91s | 1.63s | 1.74s | 100% | 100.80/s |
| list-quotas | 297.74ms | 178.32ms | 297.43ms | 355.05ms | 338.43ms | 351.52ms | 100% | 287.81/s |
| list-repositories | 187.58ms | 53.48ms | 193.74ms | 288.44ms | 268.63ms | 270.39ms | 100% | 506.77/s |
| list-users | 28.69ms | 6.95ms | 26.24ms | 69.15ms | 51.11ms | 63.51ms | 100% | 2326.48/s |
| pull-artifacts-from-different-projects | 3.82s | 1.37s | 3.64s | 8.74s | 5.52s | 6.97s | 100% | 2.59/s |
| pull-artifacts-from-same-project | 8.09s | 290.29ms | 6.91s | 20.58s | 17.18s | 18.82s | 100% | 8.71/s |
| push-artifacts-to-different-projects | 6.99s | 2.55s | 6.25s | 15.09s | 11.41s | 13.03s | 100% | 6.49/s |
| push-artifacts-to-same-projects | 24.64s | 5.69s | 28.11s | 36.01s | 30.84s | 31.85s | 100% | 2.62/s |
| search-users | 59.13ms | 6.83ms | 49.78ms | 126.65ms | 109.5ms | 114.8ms | 100% | 1438.24/s |
