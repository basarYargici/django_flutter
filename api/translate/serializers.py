from rest_framework import serializers

from .models import Translate


class TranslateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Translate
        fields = '__all__'
