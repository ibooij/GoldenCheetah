/*
 * Copyright (c) 2009 Mark Liversedge (liversedge@gmail.com)
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation; either version 2 of the License, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc., 51
 * Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 */

#ifndef _ErgFile_h
#define _ErgFile_h

#include <QtGui>
#include <QObject>
#include <QDebug>
#include <QString>
#include <QDate>
#include <QStringList>
#include <QFile>
#include <QTextStream>
#include <QRegExp>
#include "Zones.h"      // For zones ... see below vvvv

// which section of the file are we in?
#define NOMANSLAND  0
#define SETTINGS 1
#define DATA     2
#define END      3

// is this in .erg or .mrc format?
#define ERG     1
#define MRC     2
#define CRS     3

class ErgFilePoint
{
    public:
        long x;     // x axis - time in msecs or distance in meters
        long y;     // y axis - load in watts or altitude

        double val;   // the value to send to the device (watts/gradient)
};

class ErgFileLap
{
    public:
        long x;     // when does this LAP marker occur? (time in msecs or distance in meters
        int LapNum;     // from 1 - n
};

class ErgFile
{
    public:
        ErgFile(QString, int&, double Cp);       // constructor uses filename
        ~ErgFile();             // delete the contents

        bool isValid();         // is the file valid or not?
        int wattsAt(long, int&);      // return the watts value for the passed msec
        double gradientAt(long, int&);      // return the gradient value for the passed meter
        int nextLap(long);      // return the msecs value for the next Lap marker

        QString Version,        // version number / identifer
                Units,          // units used
                Filename,       // filename from inside file
                Name,           // workout name
                Format;         // only ever seen MINUTES  WATTS
        long    Duration;       // Duration of this workout in msecs
        int     Ftp;            // FTP this file was targetted at
        int     MaxWatts;       // maxWatts in this ergfile (scaling)
        bool valid;             // did it parse ok?

    int leftPoint, rightPoint;            // current points we are between

    QList<ErgFilePoint> Points;    // points in workout
    QList<ErgFileLap>   Laps;      // interval markers in the file
};

#endif
