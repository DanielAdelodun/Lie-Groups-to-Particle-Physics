# Dockerfiles

Dockerfiles used to create [jupyterhub](https://jupyterhub.readthedocs.io/en/1.4.1/)-ready images, with tools for 'math animation'.  
All of images come with [manim](https://docs.manim.community/en/v0.7.0/installation.html) and [matplotlib](https://matplotlib.org/3.4.2/api/animation_api.html) - along with some combination of [sagemath](https://www.sagemath.org/) and [scipy](https://docs.scipy.org/doc/scipy/reference/)+[julia](https://docs.julialang.org/en/v1/)+[R](https://www.r-project.org/)  

Use these as a template to build your own math animation images.  

If you would like one of these images, download them straight dockerhub:
- `danielade/liegroup` -> Just manim & matplotlib,
- `danielade/datascience` -> The above, plus scipy+julia+R,
- `danielade/sagemath` -> manim, matplotlob and sagemath,
- `danielade/extra` -> All of the above.

To use the above images with [mybinder](https://mybinder.org/), make a repo with a single file. Specifically, create a Dockerfile with the line   
`FROM <IMAGE-NAME>`   
and follow then instructions at [mybinder](https://mybinder.org/).
  


