# Base image
FROM python:3.9

# Copy source files
COPY . .

# Install all requirements
RUN pip install -r requirements.txt

# Run run.py
CMD ["python", "run.py"]