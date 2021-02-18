from django.db import models


# Create your models here.

class TranslateModel(models.Model):
    english = models.CharField(max_length=100)
    turkish = models.CharField(max_length=100)

    def __str__(self):
        return self.english
