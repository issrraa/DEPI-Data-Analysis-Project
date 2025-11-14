import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
import squarify
from PIL import Image

st.set_page_config(page_title="Healthcare Analytics", layout="wide")

try:
    project_image = Image.open(r"C:\Users\Radwa\OneDrive\Pictures\Screenshots\Screenshot 2025-11-01 005512.png")

    st.image(project_image,use_container_width=True)
except:
    st.info("⚠️ صورة المشروع غير متوفرة، تأكد من وجود الملف في المسار الصحيح")

st.markdown("<h1 style='text-align: center; color: blue;'>📊 SmartCare Hospital Analytics System </h1>", 
            unsafe_allow_html=True)

encounters = pd.read_csv(r"D:\SmartCare Hospital\encounters.csv", parse_dates=['visit_date'])
patients = pd.read_csv(r"D:\SmartCare Hospital\patients.csv", parse_dates=['dob'])
providers = pd.read_csv(r"D:\SmartCare Hospital\providers.csv")
billing = pd.read_csv(r"D:\SmartCare Hospital\claims_and_billing.csv", parse_dates=['claim_billing_date'])
denials = pd.read_csv(r"D:\SmartCare Hospital\denials.csv", parse_dates=['denial_date'])
procedures = pd.read_csv(r"D:\SmartCare Hospital\procedures.csv")
medications = pd.read_csv(r"D:\SmartCare Hospital\medications.csv", parse_dates=['prescribed_date'])


st.title("SmartCare Hospital Analytics")

# KPI Cards:

st.subheader("Key Metrics")
total_patients = patients['patient_id'].nunique()
total_procedures = procedures['procedure_id'].count()
total_encounters = encounters['encounter_id'].nunique()
total_claims = billing['claim_id'].nunique()
total_denials = denials['denial_id'].nunique()

col1, col2, col3, col4, col5 = st.columns(5)

col1.metric("Total Patients", total_patients)
col2.metric("Total Procedures", total_procedures)
col3.metric("Total Encounters", total_encounters)
col4.metric("Total Claims", total_claims)
col5.metric("Total Denials", total_denials)

#  Encounters per Department
st.subheader("Encounters per Department")
dept_counts = encounters['department'].value_counts()
fig1, ax1 = plt.subplots(figsize=(6,4))
dept_counts.plot(kind='bar', color='lightcoral', ax=ax1)
ax1.set_xlabel("Department")
ax1.set_ylabel("Number of Encounters")
st.pyplot(fig1)

# Visit Type Distribution
st.subheader("Visit Type Distribution")
visit_counts = encounters['visit_type'].value_counts()
fig2, ax2 = plt.subplots(figsize=(5,5))
visit_counts.plot(kind='pie', autopct='%1.1f%%', startangle=90,
                  colors=['#FF9999','#66B3FF','#99FF99','#FFCC99'])
ax2.set_ylabel("")
st.pyplot(fig2)

# Readmission Percentage
st.subheader("Readmission Percentage")
if 'readmission' in encounters.columns:
    readmission_pct = encounters['readmission'].value_counts(normalize=True).get('Yes', 0) * 100
    st.write(f"**Readmission Percentage:** {readmission_pct:.2f}%")
else:
    st.write("Column 'readmission' not found in encounters data.")

# Top 6 Reasons for Visit
st.subheader("Top 6 Reasons for Visit")
top_reasons = encounters['reason_for_visit'].value_counts().head(6)
fig4, ax4 = plt.subplots(figsize=(6,4))
top_reasons.plot(kind='bar', color='lightcoral', ax=ax4)
ax4.set_xlabel("Reason for Visit")
ax4.set_ylabel("Number of Encounters")
st.pyplot(fig4)
fig, ax = plt.subplots(figsize=(5,5))

# gender distribution
patients['gender'].value_counts().plot(
    kind='pie',
    autopct='%1.1f%%',
    startangle=90,
    colors=['pink','lightblue'],
    ax=ax
)
ax.set_ylabel("")
ax.set_title("Gender Distribution")
st.pyplot(fig)
