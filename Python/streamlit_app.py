import streamlit as st
from PIL import Image

st.set_page_config(
    page_title="SmartCare Hospital Analytics System",
    layout="wide"
)

st.markdown("""
    <h1 style='text-align: center; color: #4B8BBE;'>
        SmartCare Hospital Analytics System
    </h1>
""", unsafe_allow_html=True)
try:
    project_image = Image.open(r"C:\Users\Radwa\OneDrive\Pictures\Screenshots\Screenshot 2025-11-01 005512.png")

    st.image(project_image,use_container_width=True)
except:
    st.info("⚠️ صورة المشروع غير متوفرة، تأكد من وجود الملف في المسار الصحيح")

st.write("Welcome!.")

