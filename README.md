# 3D Noise Visualization With Marching Cube Algorithm

## Abstract
3D visualizations of different noises using the marching cubes algorithm. Those ones are animated by varying the iso-surface value with time. The final result can be watched on [Vimeo](https://vimeo.com/808352034).

## Introduction
As an art and image technology students, we are used to using 2D noise textures, especially in a realistic / organic artistic approach to represent the complexity of the world around us. After watching a video by Daniel Shiffman about the square marching algorithm, I was curious to represent these noises in a three dimensional space, images that I could not find, especially on the Internet. To achieve this goal, I combined the cube marching algorithm with the most commonly used noise algorithms (Perlin,Worley, Simplex), in a Processing programming context.


## Algorithm Explanation
Before explaining the 3D cube marching algorithm, I think it would be better to explain the 2D square marching algorithmwhich is easier to mentally imagine.

### Square Marching Algorithm
The Marching Squares algorithm is a computer graphics algorithm introduced in the 1980s that can be used to create a contour map or isoline of a 2D scalar field. The algorithm works by dividing the scalar field into a grid of square cells, where each cell is defined by its four corner points. The we iterate through the grid to determine the vertex state in comparison to an iso-value 𝜎. Each grid vertex is now assigned a binary state (0 or 1).

The configuration of each sub-grid is matched with one entry in the contours lookup table below.

[Image00](images/sq_march_00.png)


We think of the dark blue region as the interior of an object, and the light blue region as the exterior of the object. We denote the 𝑂𝑁 (1) state by a black vertex and the 𝑂𝐹 𝐹 (0) state by a white vertex. Thus, the configuration 7 = (0111)2 must correspond to an object whose contour intersects the top and left edges of the square. In this fashion, the contours in each sub-grid are approximated.
