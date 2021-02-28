from django.db import models


class Translate(models.Model):
    english = models.CharField(max_length=100)
    turkish = models.CharField(max_length=100)

    def __str__(self):
        return self.english
