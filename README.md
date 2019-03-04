# 这个仓库是对论文《Stabilization and asymptotic path tracking of a rolling disk》的复现
## **1.Introduction**：此论文描述的是一个滚动圆盘在平面上滚动（保持圆盘直立状态），利用高等动力学知识，使用拉格朗日-欧拉方程求解动力学结果，对圆盘进行动力学控制，使其绕平面的一个圆形轨迹运动。
## **2.运行结果如下图所示**
* 圆盘轨迹，![Result](imgae/Result.jpg)
* 倾斜角控制，![Result](imgae/Result.jpg)
* 转向角控制，![Result](imgae/Result.jpg)
* 滚动角控制，![Result](imgae/Result.jpg)
## **3.代码结构**
* `src/examle`是示例代码，供了解ode函数的使用。
* `src/src/Execution.m`,显示复现结果。 
* `src/rotate_matrix_test.m`是欧拉旋转矩阵的符号计算。
* `src/odefun.m`是微分方程求解。

复现结果如图![Result](imgae/Result.jpg)