from django.db import models


# Create your models here.
class Synonym(models.Model):
    word = models.CharField(max_length=60)
    synonym = models.CharField(max_length=60)
    description = models.TextField()

    def __str__(self):
        return self.word
