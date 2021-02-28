from rest_framework import viewsets

from .models import Synonym
from .serializers import SynonymSerializer


class SynonymViewSet(viewsets.ModelViewSet):
    queryset = Synonym.objects.all()
    serializer_class = SynonymSerializer
