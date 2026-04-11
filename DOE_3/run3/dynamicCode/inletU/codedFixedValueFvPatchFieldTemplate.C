/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     | Website:  https://openfoam.org
    \\  /    A nd           | Copyright (C) YEAR OpenFOAM Foundation
     \\/     M anipulation  |
-------------------------------------------------------------------------------
License
    This file is part of OpenFOAM.

    OpenFOAM is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    OpenFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with OpenFOAM.  If not, see <http://www.gnu.org/licenses/>.

\*---------------------------------------------------------------------------*/

#include "codedFixedValueFvPatchFieldTemplate.H"
#include "addToRunTimeSelectionTable.H"
#include "fvPatchFieldMapper.H"
#include "volFields.H"
#include "surfaceFields.H"
#include "unitConversion.H"
//{{{ begin codeInclude

//}}} end codeInclude


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

// * * * * * * * * * * * * * * * Local Functions * * * * * * * * * * * * * * //

//{{{ begin localCode

//}}} end localCode


// * * * * * * * * * * * * * * * Global Functions  * * * * * * * * * * * * * //

extern "C"
{
    // dynamicCode:
    // SHA1 = fb71ebe6aad44e45e78156d0a83ada01569fee88
    //
    // unique function name that can be checked if the correct library version
    // has been loaded
    void inletU_fb71ebe6aad44e45e78156d0a83ada01569fee88(bool load)
    {
        if (load)
        {
            // code that can be explicitly executed after loading
        }
        else
        {
            // code that can be explicitly executed before unloading
        }
    }
}

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

makeRemovablePatchTypeField
(
    fvPatchVectorField,
    inletUFixedValueFvPatchVectorField
);


const char* const inletUFixedValueFvPatchVectorField::SHA1sum =
    "fb71ebe6aad44e45e78156d0a83ada01569fee88";


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

inletUFixedValueFvPatchVectorField::
inletUFixedValueFvPatchVectorField
(
    const fvPatch& p,
    const DimensionedField<vector, volMesh>& iF
)
:
    fixedValueFvPatchField<vector>(p, iF)
{
    if (false)
    {
        Info<<"construct inletU sha1: fb71ebe6aad44e45e78156d0a83ada01569fee88"
            " from patch/DimensionedField\n";
    }
}


inletUFixedValueFvPatchVectorField::
inletUFixedValueFvPatchVectorField
(
    const fvPatch& p,
    const DimensionedField<vector, volMesh>& iF,
    const dictionary& dict
)
:
    fixedValueFvPatchField<vector>(p, iF, dict)
{
    if (false)
    {
        Info<<"construct inletU sha1: fb71ebe6aad44e45e78156d0a83ada01569fee88"
            " from patch/dictionary\n";
    }
}


inletUFixedValueFvPatchVectorField::
inletUFixedValueFvPatchVectorField
(
    const inletUFixedValueFvPatchVectorField& ptf,
    const fvPatch& p,
    const DimensionedField<vector, volMesh>& iF,
    const fvPatchFieldMapper& mapper
)
:
    fixedValueFvPatchField<vector>(ptf, p, iF, mapper)
{
    if (false)
    {
        Info<<"construct inletU sha1: fb71ebe6aad44e45e78156d0a83ada01569fee88"
            " from patch/DimensionedField/mapper\n";
    }
}


inletUFixedValueFvPatchVectorField::
inletUFixedValueFvPatchVectorField
(
    const inletUFixedValueFvPatchVectorField& ptf,
    const DimensionedField<vector, volMesh>& iF
)
:
    fixedValueFvPatchField<vector>(ptf, iF)
{
    if (false)
    {
        Info<<"construct inletU sha1: fb71ebe6aad44e45e78156d0a83ada01569fee88 "
            "as copy/DimensionedField\n";
    }
}


// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

inletUFixedValueFvPatchVectorField::
~inletUFixedValueFvPatchVectorField()
{
    if (false)
    {
        Info<<"destroy inletU sha1: fb71ebe6aad44e45e78156d0a83ada01569fee88\n";
    }
}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

void inletUFixedValueFvPatchVectorField::updateCoeffs()
{
    if (this->updated())
    {
        return;
    }

    if (false)
    {
        Info<<"updateCoeffs inletU sha1: fb71ebe6aad44e45e78156d0a83ada01569fee88\n";
    }

//{{{ begin code
    #line 59 "/home/rico-reiser/cases_OF10/new_cases/freeze5/0/U/boundaryField/inlet"
// Current time [s]
        const scalar t = this->db().time().value();

        // Parameters
        const scalar Umax  = 0.1;   // [m/s]
        const scalar tramp = 0.2;   // ramp-up time [s]
        const scalar tOff  = 1.0;   // switch off after [s] (set very large to never switch off)

        // Compute inlet speed with ramp
        scalar Uin = 0.0;

        if (t < tOff)
        {
            Uin = Umax*min(t/(tramp + VSMALL), scalar(1));
        }
        else
        {
            Uin = 0.0;
        }

        // Assign on patch faces
        vectorField& Up = *this;

        forAll(Up, facei)
        {
            Up[facei] = vector(Uin, 0, 0);
        }
//}}} end code

    this->fixedValueFvPatchField<vector>::updateCoeffs();
}


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// ************************************************************************* //

