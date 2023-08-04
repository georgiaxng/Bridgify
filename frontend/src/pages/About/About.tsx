import React, { useEffect, useState } from 'react';
import { Link, Navigate } from 'react-router-dom';
import { ResponsiveAppBar } from '../../Navbar';
import { Box, Grid, Typography } from '@mui/material';
import backgroundImage from '../../images/logInBackground.jpeg';
import { WidthFull } from '@mui/icons-material';


export const About = () => {

    useEffect(() => {
    }, []);
    const token = window.localStorage.getItem('accessToken');
    const userName = window.localStorage.getItem('userName');
    const accRole = window.localStorage.getItem('accRole');
    const linkedElderly = window.localStorage.getItem('linkedElderly');
    const profileImage = window.localStorage.getItem('proofileImage')
    console.log(token);
    console.log(userName);
    console.log(accRole);
    console.log(linkedElderly);
    console.log(profileImage);


    return (
        <div>
            {
                token == null ?
                    <Navigate to="/Login" /> : <Navigate to="/About" />
            }
            < ResponsiveAppBar />
            <Box
                sx={{
                    display: 'flex',
                    justifyContent: 'center',
                    alignItems: 'center',
                    margin:"auto",
                    width:"80%"

                }}
            >
                {/* <Box sx={{width:80%}}> */}
                <Grid container sx={{marginTop:10,marginBottom:10, borderRadius:5, p:3, border:"3px solid #C5D3D0"}}>
                <Grid item xs={5} sx={{
                        backgroundImage: `url(${backgroundImage})`,
                        backgroundRepeat: 'no-repeat',
                        backgroundSize: 'cover',
                    }}>
                    </Grid>
                    <Grid item xs={7} >
                        <div style={{ width: "80%", margin: "auto", alignContent: "center", justifyContent: "center", marginTop: "5%" }}>
                            <Typography variant="h3" component="h1" gutterBottom sx={{ textAlign: "center" }}>
                                About Us
                            </Typography>
                            <Typography variant="h5" paragraph lineHeight={1.5} sx={{ textAlign: "justify" }} >
                                Welcome to Bridgify! We are a passionate team dedicated to redefining family connections and elderly care in Singapore.
                                With the growing elderly population and the challenges of modern life, we saw a need for a solution that brings families closer together.<br/><br/>

                                Our mission is clear: to empower families by keeping them effortlessly connected with their elderly loved ones. Through our innovative solution, caregivers and care centers provide real-time updates on health, activities, and well-being, ensuring you're always in the know and your loved ones are always cared for.

                            </Typography>
                        </div>
                    </Grid>
                </Grid>

                
            </Box>

        </div>
    )
}